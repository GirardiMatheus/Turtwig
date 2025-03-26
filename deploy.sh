#!/bin/bash
set -eo pipefail

# ------------------------
# Initialization
# ------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"

# Load configuration
if [ ! -f "${ENV_FILE}" ]; then
    echo "[ERROR] .env file not found at ${ENV_FILE}" >&2
    exit 1
fi
source "${ENV_FILE}"

# Validate essential variables
required_vars=("REPO_DIR" "BRANCH" "COMPOSE_PROJECT_NAME")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "[ERROR] ${var} must be set in .env" >&2
        exit 1
    fi
done

# Initialize log file
mkdir -p "$(dirname "${LOG_FILE}")"
exec > >(tee -a "${LOG_FILE}") 2>&1

# ------------------------
# Logging Functions
# ------------------------
log() {
    local level=$1
    local message=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [${level^^}] ${message}"
}

# ------------------------
# Deployment Functions
# ------------------------
check_dependencies() {
    for cmd in git docker docker-compose; do
        if ! command -v "${cmd}" >/dev/null 2>&1; then
            log "ERROR" "Required command not found: ${cmd}"
            exit 1
        fi
    done
}

git_update() {
    log "INFO" "Updating repository (branch: ${BRANCH})"
    git -C "${REPO_DIR}" checkout "${BRANCH}"
    git -C "${REPO_DIR}" pull origin "${BRANCH}"
    COMMIT_HASH=$(git -C "${REPO_DIR}" rev-parse --short HEAD)
    log "INFO" "Current commit: ${COMMIT_HASH}"
}

docker_operations() {
    log "INFO" "Stopping existing containers"
    docker-compose -f "${REPO_DIR}/${COMPOSE_FILE}" down

    log "INFO" "Rebuilding containers"
    docker-compose -f "${REPO_DIR}/${COMPOSE_FILE}" up -d --build

    log "INFO" "Container status:"
    docker-compose -f "${REPO_DIR}/${COMPOSE_FILE}" ps
}

# ------------------------
# Main Execution
# ------------------------
main() {
    log "INFO" "Starting deployment"
    check_dependencies
    git_update
    docker_operations
    log "INFO" "Deployment completed successfully"
    
    # Show recent logs
    log "INFO" "Tail of container logs:"
    docker-compose -f "${REPO_DIR}/${COMPOSE_FILE}" logs --tail=20
}

main