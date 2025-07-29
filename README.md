# 🏛️ Desafio Gestiona Tecnologia - API de Consulta de Créditos Constituídos

[![Java](https://img.shields.io/badge/Java-8+-orange.svg)](https://openjdk.java.net/projects/jdk8/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.x-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Angular](https://img.shields.io/badge/Angular-19-red.svg)](https://angular.io/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13-blue.svg)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![Kafka](https://img.shields.io/badge/Apache%20Kafka-Messaging-orange.svg)](https://kafka.apache.org/)

> Sistema completo para consulta de créditos constituídos (ISSQN) com arquitetura moderna, cobertura de testes, mensageria e containerização com Docker.

---

## 📋 Índice

* [🎯 Visão Geral](#-visão-geral)
* [📦 Estrutura do Projeto](#-estrutura-do-projeto)
* [🗃️ Componentes Dockerizados](#️-componentes-dockerizados)
* [🔧 Setup e Execução](#-setup-e-execução)
* [📚 Documentação](#-documentação)
* [🔗 Repositórios Relacionados](#-repositórios-relacionados)
* [👨‍💻 Desenvolvedor](#-desenvolvedor)

---

## 🎯 Visão Geral

Este projeto implementa uma arquitetura full stack moderna com backend Java 8 + Spring Boot e frontend Angular 19, integrados via REST e orquestrados com Docker Compose.

A proposta é oferecer uma solução completa para consulta de créditos constituídos do ISSQN, contemplando:

* API RESTful com documentação Swagger
* Frontend responsivo e desacoplado
* Banco PostgreSQL + scripts versionados
* Kafka para eventos de auditoria
* Ambiente completo com containers reutilizáveis

---

## 📦 Estrutura do Projeto

```
desafio-gestiona-tecnologia/
├── 📁 backend/                        # API REST - Spring Boot
│   └── Dockerfile                    # Docker do backend
├── 📁 frontend/                      # Aplicação Angular 19
│   └── Dockerfile                    # Docker do frontend
├── 📁 database/
│   └── init.sql                      # Criação e carga inicial do banco
├── 📁 kafka/
│   └── docker-compose.kafka.yml     # Setup Kafka + Zookeeper
├── docker-compose.yml               # Orquestração completa
├── .gitignore
└── README.md                        # Este arquivo
```

---

## 🗃️ Componentes Dockerizados

| Serviço     | Descrição                             | Porta |
| ----------- | ------------------------------------- | ----- |
| PostgreSQL  | Banco de dados relacional             | 5432  |
| API Backend | Spring Boot + Java 8                  | 8080  |
| Frontend    | Angular 19 (ng serve ou SSR opcional) | 4200  |
| Kafka       | Mensageria de auditoria               | 9092  |
| Zookeeper   | Dependência do Kafka                  | 2181  |

---

## 🔧 Setup e Execução

### 🐳 Subir o ambiente completo

Pré-requisitos:

* Docker e Docker Compose instalados

```bash
git clone https://github.com/ednilton/desafio-gestiona-tecnologia.git
cd desafio-gestiona-tecnologia
docker-compose up -d
```

Acesse:

* 🔗 API: [http://localhost:8080](http://localhost:8080)
* 📖 Swagger: [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
* 🌐 Frontend: [http://localhost:4200](http://localhost:4200)

### 📤 Derrubar os containers

```bash
docker-compose down
```

---

## 📚 Documentação

* Swagger UI disponível via backend
* Scripts SQL em `database/init.sql`
* Setup de mensageria em `kafka/docker-compose.kafka.yml`
* Deploy local rápido com `docker-compose`

---

## 🔗 Repositórios Relacionados

| Módulo              | Repositório                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------- |
| 📚 Infraestrutura   | [desafio-gestiona-tecnologia](https://github.com/ednilton/desafio-gestiona-tecnologia)       |
| 🔙 Backend API      | [api-consulta-creditos-backend](https://github.com/ednilton/api-consulta-creditos-backend)   |
| 🔜 Frontend Angular | [api-consulta-creditos-frontend](https://github.com/ednilton/api-consulta-creditos-frontend) |

---

## 👨‍💻 Desenvolvedor

**Ednilton Curt Rauh**
📧 [edrauh@gmail.com](mailto:edrauh@gmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/ednilton-rauh-63838a47)

---

Este repositório representa o núcleo de execução e integração do projeto, centralizando os componentes essenciais para o funcionamento local e a entrega completa do desafio técnico.
