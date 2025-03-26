<div align="center">
  <h1>
    <img src="./assets/turtwig.svg" width="40" height="40" alt="Turtwig" style="vertical-align: middle;">
    Turtwig
  </h1>
  <p>Automação de Deploy para Aplicações Dockerizadas</p>
  
  <p>
    <img src="https://img.shields.io/badge/Shell_Script-100%25-brightgreen" alt="Shell">
    <img src="https://img.shields.io/badge/Docker-2CA5E0?logo=docker" alt="Docker">
    <img src="https://img.shields.io/badge/license-MIT-blue" alt="License">
  </p>
</div>

##  Visão Geral

O Turtwig é uma solução robusta para automação de deploy de aplicações containerizadas, combinando:

- Atualização automática de repositórios Git
- Gerenciamento inteligente de containers Docker
- Logging detalhado para monitoramento

##  Funcionalidades Principais

 **Sincronização de Código**  
- Pull automático da branch especificada  
- Verificação de hash do commit para rastreabilidade  

 **Gerenciamento de Containers**  
- Parada segura de containers existentes  
- Rebuild inteligente com cache optimization  
- Verificação de saúde dos containers  

 **Monitoramento**  
- Logging estruturado com timestamps  
- Exibição dos últimos logs dos containers  
- Saída colorida para fácil visualização  

##  Pré-requisitos

- Docker 20.10+
- Docker Compose 2.0+
- Git 2.20+
- Bash 4.0+

##  Instalação Rápida

1. Clone o repositório:
```bash
git clone https://github.com/GirardiMatheus/Turtwig.git && cd Turtwig
```

2. Configure o ambiente:
```bash
cp .env.example .env
# Edite as variáveis conforme necessário
nano .env
```
3. Torne o script executável:
```bash
chmod +x deploy.sh
```

##  Como Usar

**Deploy básico:** 
```bash
./deploy.sh
```

**Modo verboso (debug):** 
```bash
DEBUG=true ./deploy.sh
```

## Estrutura do Projeto

```bash
Turtwig/
├── deploy.sh             # Script principal
├── .env.example          # Template de configuração
├── .gitignore           # Padrão para projetos Docker
├── assets/
│   └── turtwig.svg      # Mascote do projeto
└── README.md            # Esta documentação
```

## Melhores Práticas

1. Ambientes múltiplos:
```bash
# Para staging:
APP_ENV=staging ./deploy.sh

# Para produção:
APP_ENV=production ./deploy.sh
```

2. Configure o ambiente:

    O script inclui verificações de integridade que abortam o deploy em caso de falha.

## Contribuição

1. Fork o projeto
2. Crie sua branch (git checkout -b feature/fooBar)
3. Commit suas mudanças (git commit -am 'Add some fooBar')
4. Push para a branch (git push origin feature/fooBar)
5. Abra um Pull Request