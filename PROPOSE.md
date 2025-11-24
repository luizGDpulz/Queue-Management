# Proposta Completa — Sistema Integrado de Gestão de Estoque e Vendas (Resumo + Duas Implementações)

## Visão geral

Sistema multiplataforma para **gestão de estoque, vendas e cadastro de produtos**, composto por:

* **API back-end robusta e segura** (duas opções: **PHP puro** ou **FastAPI (Python)**);
* **Banco de dados relacional** (MySQL / PostgreSQL);
* **Aplicação Web responsiva** consumindo a API via **AJAX** (painel administrativo, dashboards, relatórios);
* **Aplicativo Mobile em Kotlin** (cadastro rápido de produtos, leitura de código de barras, atualização de estoque);
* **Opção de integração com Smartwatch** (notificações + fluxo rápido para ajustes de estoque);
* **Módulo de vendas**, relatórios e indicadores (KPIs: giro de estoque, top vendas, estoque mínimo, etc.);
* Gestão do projeto com metodologia ágil (sprints, backlog, entregáveis) e documentação completa (ER, requisitos, manual, vídeo).

O objetivo é entregar um sistema demonstrável, escalável, seguro e com boa UX — adequado como Projeto Integrador Final.

---

# OPÇÃO A — API em PHP Puro

## 1. Objetivo da opção

Construir uma API REST em **PHP 8+ sem frameworks** para demonstrar domínio profundo da linguagem e da arquitetura de backend. Ideal se você quer **mostrar o trabalho do zero**.

## 2. Estrutura / arquitetura sugerida

```
/api
  /public
    index.php            # ponto de entrada + .htaccess
  /core
    Router.php
    Controller.php
    Response.php
    Middleware.php
    ErrorHandler.php
    Auth.php             # JWT handling
  /config
    config.php
  /database
    Connection.php
    Migrations/
    Seeds/
  /modules
    /Products
      ProductController.php
      ProductService.php
      ProductRepository.php
      ProductModel.php
    /Sales
    /Users
    /Reports
  /utils
    Validator.php
    Logger.php
    Mailer.php
```

## 3. Tecnologias e infra

* PHP 8+ (tipagem, exceptions, attributes se quiser)
* Apache / Nginx + mod_rewrite para roteamento (ou front controller)
* PDO (prepared statements) — MySQL ou PostgreSQL
* JWT para autenticação + refresh tokens
* Composer para dependências utilitárias (monolog, firebase/php-jwt, phpoffice para exportar xlsx/pdf libs)
* PHPMailer (opcional), mPDF para PDFs
* Git (versionamento), Docker (ambiente local opcional)

## 4. Principais módulos e endpoints (exemplos)

**Auth**

* `POST /auth/login` → retorna access_token + refresh_token
* `POST /auth/refresh` → novo access_token
* `POST /auth/logout`

**Produtos**

* `GET /products` → lista (filtros, paginação)
* `GET /products/{id}`
* `POST /products` → criar
* `PUT /products/{id}` → atualizar
* `DELETE /products/{id}`

**Estoque**

* `POST /stock/in` → entrada de estoque
* `POST /stock/out` → saída de estoque
* `GET /stock/{product_id}` → consulta

**Vendas**

* `POST /sales` → registrar venda (itens, total, impostos)
* `GET /sales/{id}`
* `GET /sales?from=...&to=...`

**Relatórios**

* `GET /reports/stock-status`
* `GET /reports/top-products`

## 5. Banco de dados (esquema básico)

Tabelas essenciais:

* `users (id, name, email, password_hash, role, created_at)`
* `products (id, sku, name, description, price, min_stock, image_url, created_at)`
* `categories (id, name)`
* `suppliers (id, name, contact)`
* `stock_movements (id, product_id, qty, type[in/out], reason, user_id, created_at)`
* `sales (id, user_id, total, payment_method, created_at)`
* `sale_items (id, sale_id, product_id, qty, unit_price)`
* `logs_audit (id, user_id, action, data, created_at)`

Use migrations e seeds para testes.

## 6. Validação, segurança e boas práticas

* Prepared statements + validação (Validator central)
* Sanitização de inputs e escape ao exibir dados no frontend
* JWT com claims e tempo curto; refresh token com armazenamento seguro (DB)
* Tratamento centralizado de erros e códigos HTTP consistentes
* Rate limiting (simples: IP + endpoint) e throttling para endpoints sensíveis
* Logs estruturados (monolog) e auditoria de ações críticas

## 7. Web (frontend) e comunicação AJAX

* Frontend: HTML + CSS (Tailwind ou Bootstrap) + JS (fetch/axios)
* Estrutura: login, dashboard, produtos, estoque, vendas, relatórios, usuários
* Gráficos: Chart.js
* Upload de imagens: endpoint de upload seguro (validação de MIME, tamanho, armazenamento organizado)

## 8. Mobile (Kotlin)

Funcionalidades:

* Login via API (salvar token com segurança)
* Cadastro rápido de produto (form simples + foto)
* Leitura de código de barras (ZXing)
* Consulta de estoque e histórico rápido
* Sincronização offline simples (cache mínimo) — opcional

## 9. Smartwatch (opcional)

* Wear OS: notificações push (via Firebase Cloud Messaging) ou integração direta com app mobile usando mensagens
* Notificações importantes: produto abaixo de estoque mínimo, venda concluída, meta atingida
* Fluxo rápido: permitir ações simples (ex.: +1 entrada) que disparem chamadas à API

## 10. Vantagens / Desvantagens

**Vantagens**

* Demonstração técnica profunda
* Controle total do código e dependências
* Performance leve (sem overhead de framework)

**Desvantagens**

* Maior tempo de desenvolvimento
* Mais responsabilidade para acertar segurança e padronização

---

# OPÇÃO B — API com FastAPI (Python)

## 1. Objetivo da opção

Criar uma API moderna, documentada automaticamente, com produtividade alta, validação robusta e estrutura limpa — ideal se quiser focar funcionalidade e entregáveis.

## 2. Estrutura / arquitetura sugerida

```
/app
  /api
    /v1
      products.py
      sales.py
      users.py
  /core
    config.py
    security.py
    deps.py          # dependências de rota
  /models
    product.py
    user.py
    sale.py
  /schemas
    product_schema.py
    user_schema.py
  /services
    product_service.py
    stock_service.py
  /db
    session.py
    base.py
  /alembic
  main.py
```

## 3. Tecnologias e infra

* Python 3.11/3.12
* FastAPI + Uvicorn (ASGI)
* SQLAlchemy ORM + Alembic (migrations)
* Pydantic (schemas/validações)
* PostgreSQL (recomendado) ou MySQL
* Docker compose (api + db + redis se precisar)
* JWT/OAuth2 para autenticação
* Celery / RQ + Redis para tarefas assíncronas (emails, geração de relatórios pesados)

## 4. Principais módulos e endpoints (exemplos)

Mesmos endpoints do PHP, com swagger automático:

* `/docs` (Swagger UI) e `/redoc` (documentação)
* Auth: `/auth/login`, `/auth/refresh`, `/auth/logout`
* Products, Stock, Sales, Reports com endpoints RESTful

## 5. Banco de dados (esquema básico)

Idêntico à versão PHP (mesmas tabelas). Utilize models SQLAlchemy com relacionamentos e migrations com Alembic.

## 6. Validação, segurança e boas práticas

* Pydantic valida e parseia dados automaticamente (tipo-safe)
* OAuth2PasswordBearer + JWT para autenticação
* Dependências (Depends) para permissões/roles
* Middlewares para CORS, logging, rate limiting (starlette middleware)
* Testes com pytest + testclient do FastAPI

## 7. Web (frontend) e comunicação AJAX

* Mesma abordagem (fetch/axios)
* Frontend consome endpoints e usa os schemas Pydantic como fonte de verdade para payloads

## 8. Mobile (Kotlin)

* Mesmas features: login, cadastro rápido, leitura de barras, consulta de estoque
* Suporte offline opcional (Room + sync), fácil integração com endpoints JSON

## 9. Smartwatch (opcional)

* Notificações via Firebase Cloud Messaging (FCM) ou servidor push próprio
* Fluxo rápido: chamadas diretas para endpoints (com autenticação adequada) ou mensageria via MQTT/FCM

## 10. Vantagens / Desvantagens

**Vantagens**

* Desenvolvimento mais rápido e com menos código boilerplate
* Documentação automática (ajuda na apresentação do PIF)
* Validação forte via Pydantic
* Mais fácil de escalar e manter

**Desvantagens**

* Menos "feito do zero" (mas demonstra domínio de arquiteturas modernas)
* Requer domínio de ecosistema Python (Alembic/SQLAlchemy/async se usar)

---

# Comparativo rápido (resumo técnico)

| Critério                             |                          PHP Puro |                          FastAPI |
| ------------------------------------ | --------------------------------: | -------------------------------: |
| Tempo de implementação               |                              Alto |                            Baixo |
| Facilidade de manutenção             |                             Médio |                             Alto |
| Curva de aprendizado do stack        | Baixa (se já conhece PHP) / Médio |      Médio (Python + SQLAlchemy) |
| Documentação automática              |                               Não |              Sim (Swagger/Redoc) |
| Demonstração técnica “feito do zero” |                         Excelente |               Bom (mas com libs) |
| Validação de payloads                |                            Manual |            Pydantic (automático) |
| Suporte a tarefas assíncronas        |                   Manual / custom |             Fácil (Celery/async) |
| Deploy típico                        |              LAMP/NGINX + PHP-FPM | Uvicorn/gunicorn + ASGI + Docker |

---

# Entregáveis sugeridos para o PIF

* Código fonte completo (repositório Git com branches e commits claros)
* Documentação do projeto:

  * Capa, objetivo, justificativa, escopo
  * Requisitos funcionais e não-funcionais
  * Diagrama ER e diagrama de arquitetura (fluxo de dados)
  * Rotas/endpoints com exemplos (ex.: Postman collection ou arquivo OpenAPI)
  * Manual de implantação (Docker ou instruções com Nginx + PHP-FPM / Uvicorn)
  * Guia de uso (tela a tela)
* Scripts de migração e seeds (Alembic ou migrations próprias)
* Testes automatizados básicos (unit + integração)
* Vídeo de apresentação (2–5 minutos) demonstrando cadastro, venda, fluxo de estoque e dashboard
* APK (ou build debug) do app Kotlin + instruções de instalação
* (Opcional) Prova de integração com smartwatch (vídeo curto)
* Plano de gestão: board do projeto (Trello/Jira), backlog e registro de sprints

---

# Boas práticas e recomendações finais

* **Comece pelo modelo de dados** (ER) — define todo o resto.
* **Defina contratos (schemas)** entre API ↔ Web ↔ Mobile (JSON examples).
* Use **migrations** desde o início.
* **Documente cedo**: o OpenAPI (FastAPI) ou um arquivo Postman ajudam na demo.
* Garanta **autenticação segura** (JWT + refresh) e HTTPS no deploy.
* Priorize funcionalidades mínimas entregáveis (MVP): produtos, estoque, vendas, dashboard. Smartwatch é diferencial.
* Faça commits pequenos e mensagens claras — o professor vai avaliar processo.
* Prepare um roteiro para a demo: login → cadastrar produto pelo mobile → dar baixa/entrada → registrar venda → mostrar dashboard.
