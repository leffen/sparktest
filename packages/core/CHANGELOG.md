# @tatou/core

## 1.0.0

### Major Changes

- Initial release of SparkTest OSS platform

  This major release introduces the complete SparkTest OSS platform for Kubernetes test orchestration:

  **@tatou/core:**
  - Core TypeScript types for Executor, Definition, Run, and Suite
  - Comprehensive sample data for demo and testing
  - Configuration utilities and validation helpers
  - Storage interfaces for type-safe data operations

  **@tatou/ui:**
  - Complete UI component library with theming support
  - Reusable application patterns and layouts
  - AppSidebar and navigation components
  - Customizable color system and dark mode support

  **@tatou/storage-service:**
  - Generic hybrid storage architecture (API + localStorage)
  - SparkTest-specific storage service implementation
  - Real-time updates and subscription patterns
  - Kubernetes integration for job management
  - Fallback mechanisms and error handling

### Minor Changes

- Add comprehensive type system and storage abstraction layer
  - Implement core TypeScript types for test definitions, executors, and runs
  - Add generic storage interface with multiple implementations
  - Support for API, local, and hybrid storage strategies
  - Enhanced type safety across the platform

### Patch Changes

- Add comprehensive testing and deployment infrastructure
  - Implement changeset-based release management
  - Add Docker containerization for production deployment
  - Set up CI/CD workflows with proper testing
  - Add comprehensive documentation and examples

## 0.2.1

### Patch Changes

- Add changeset workflow documentation and improve core package structure
