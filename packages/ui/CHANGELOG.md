# @tatou/ui

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

- Implement comprehensive UI component library
  - Add reusable form components for test definitions and executors
  - Create data visualization components (charts, metrics, logs)
  - Implement responsive sidebar and layout components
  - Add comprehensive styling with Tailwind CSS integration

### Patch Changes

- Add comprehensive testing and deployment infrastructure
  - Implement changeset-based release management
  - Add Docker containerization for production deployment
  - Set up CI/CD workflows with proper testing
  - Add comprehensive documentation and examples
