# 🔧 CFML App Template

Template for a modern CFML application with a containerized development environment. This template does by no means always represents the state of the art or the best possible solution, but I hope someone can benefit from it.

## ✨ Used technologies

**Backend**

-   [Lucee 5.3](https://lucee.org/) -> CFML Engine running in [Commandbox](https://www.ortussolutions.com/products/commandbox) Docker Container
-   [Taffy](https://taffy.io/) -> REST API Framework
-   [jwt-cfml](https://www.forgebox.io/view/jwt-cfml)
-   [cfmigrations](https://www.forgebox.io/view/commandbox-migrations) -> Database Migrations
-   [PostgreSQL](https://www.postgresql.org/) -> Database

**Frontend**

-   [Vue3](https://v3.vuejs.org/) -> Frontend Framework

## ⚡ Prerequisites

-   Unix based OS (Linux, MacOS, WSL2)
-   Docker (>= 24.0.5) -> This version already includes docker compose
-   make (>= 4.4.1)
-   [nvm](https://github.com/nvm-sh/nvm)
-   [commandbox](https://www.ortussolutions.com/products/commandbox) (optional -> Already running in docker container)
-   [cflint](https://github.com/cflint/CFLint/releases/tag/CFLint-1.5.0) (optional -> VsCode Extension which needs a JAR file)

## 🚀 Getting started

1. Clone the repository:
   <br /><br />
    ```bash
    git clone https://github.com/rabume/cfml-app-template
    ```
2. Enter the directory:
   <br /><br />
    ```bash
    cd cfml-app-template
    ```
3. Copy the `.env.example` file to `.env` and adjust the variables to your needs
4. Start development environment: `make dev`
5. Access the application (if not changed in `.env`):
    - Vue Frontend: http://localhost:3000 -> Login with `someGlobalKey` (if not changed in `.env`):
    - Taffy Dashboard: http://localhost:8080

#### 📝 Note

Currently, the global key is being utilized for user authentication. In a real-world application, the user would be authenticated through a login form, generating a JWT token for subsequent requests. Please note that this is just a basic illustration.

## 📦 Commands

| Command        | Description                       |
| -------------- | --------------------------------- |
| `make dev`     | Start development environment     |
| `make clean`   | Remove all containers and volumes |
| `make migrate` | Run database migrations (fresh)   |
| `make seed`    | Run database seeds                |
| `make watch`   | Watch for file changes            |

## ⛏️ Deployment

You can find the deployment configuration in the `/deploy` directory. Right now I use a `makefile` to automate the deployment process. This is optional and can be replaced. The `prod.env.example` contains the environment variables for the production environment. Instead of using a `.env` file, you can also set the environment variables directly on your server.

-   `make deploy` -> Deploy the application and runs the migrations
