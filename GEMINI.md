# Gemini Code Assistant Guide for SparkTest

This document provides a guide for using Gemini Code Assistant with the SparkTest monorepo.

## Project Overview

SparkTest is a full-stack application for running tests in a Kubernetes environment. The project is structured as a `pnpm` workspace monorepo, containing a Rust backend and a Next.js frontend.

### Technology Stack

*   **Monorepo Management**: pnpm workspaces
*   **Frontend**: Next.js, React, TypeScript, Tailwind CSS (`apps/oss`)
*   **Shared Frontend Libraries**: TypeScript, located in `packages/*`
*   **Backend**: Rust, Axum, PostgreSQL/SQLite (`backend/*`)
*   **Deployment**: Vercel (frontend), Docker/Kubernetes (backend)
*   **CI/CD**: GitHub Actions

## Monorepo Structure

*   `apps/oss/`: The main Next.js frontend application.
*   `backend/`: The Rust backend, composed of multiple crates (`api`, `bin`, `core`).
*   `packages/*`: Shared TypeScript libraries used by the frontend, such as `@tatou/core`, `@tatou/ui`, and `@tatou/storage-service`.
*   `scripts/`: Utility shell scripts for development and maintenance.
*   `.github/workflows/`: CI/CD pipeline definitions for testing, building, and deploying.

## Development Commands

The following commands should be run from the root of the monorepo.

### Prerequisites

Ensure you have `pnpm` and `rust` (with `cargo`) installed.

### Installation

To install all Node.js dependencies for the frontend and shared packages:

```bash
pnpm install
```

### Running the Development Servers

To run the frontend and backend servers concurrently:

```bash
pnpm dev:all
```

Alternatively, you can run them separately:

*   **Frontend Only**:
    ```bash
    pnpm dev:frontend
    ```
*   **Backend Only**: Before running the backend, you may need to set up a `.env` file in the root directory with the `DATABASE_URL`.
    ```bash
    # Example .env file
    # DATABASE_URL=postgres://user:password@localhost/sparktest
    ```
    Then, run the backend:
    ```bash
    pnpm dev:backend
    ```

### Building

*   **Build all frontend packages and the app**:
    ```bash
    pnpm build:packages && pnpm build:app
    ```
*   **Build the Rust backend**:
    ```bash
    pnpm cargo-build
    ```

### Testing

*   **Run all frontend and backend tests**:
    ```bash
    pnpm check:test
    ```
*   **Run frontend tests only**:
    ```bash
    pnpm test
    ```
*   **Run backend tests only**:
    ```bash
    pnpm cargo-test
    ```

### Linting and Formatting

*   **Check formatting and linting for the entire project**:
    ```bash
    pnpm lint:all
    ```
*   **Fix formatting and linting errors**:
    ```bash
    pnpm fix
    ```

## Deployment

*   The frontend (`apps/oss`) is deployed to **Vercel**.
*   The backend is designed to be containerized with **Docker** and deployed to **Kubernetes**.

For more detailed instructions, refer to `DEPLOYMENT.md` and `backend/KUBERNETES.md`.
