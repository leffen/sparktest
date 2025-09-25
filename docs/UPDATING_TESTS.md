# How to Update a Running Test in Kubernetes

This guide explains how to "update" a test that is currently running in your Kubernetes cluster using SparkTest.

## Understanding Updates in Kubernetes

In Kubernetes, `Jobs` are designed to be immutable. This means you cannot directly modify a `Job` that is already running. To "update" a test, you need to stop the existing test and start a new one with your updated configuration.

## Updating a Test via the SparkTest UI

The simplest way to update a test is by using the SparkTest web interface.

### 1. Stop the Existing Test

1.  Navigate to the main dashboard in the SparkTest UI.
2.  Find the test run that you want to update in the list of active or recent runs.
3.  Click the "Delete" or "Cancel" button for that test run. This action will send a request to the SparkTest backend to delete the corresponding Kubernetes `Job`.

### 2. Create a New Test

1.  Once the old test is stopped, you can create a new one with your desired changes.
2.  Click on the "New Test" button.
3.  In the test creation form, you can:
    *   Update the Docker image to a new version.
    *   Change the commands that are executed.
    *   Modify any other parameters.
4.  Click "Create Test" to launch the new version of your test as a new Kubernetes `Job`.

## Updating a Test via the API (for advanced users)

If you are building automation or prefer to use the command line, you can update a test by interacting with the SparkTest API directly.

### 1. Delete the Old Test Run

You will need the `job_name` of the test run you want to delete. You can get this from the SparkTest UI or by listing the test runs via the API.

Then, send a `DELETE` request to the `/api/k8s/jobs/{job_name}` endpoint.

```bash
curl -X DELETE http://localhost:3001/api/k8s/jobs/your-job-name
```

### 2. Create the New Test Run

Next, send a `POST` request to the `/api/test-runs` endpoint with the updated configuration in the request body.

```bash
curl -X POST http://localhost:3001/api/test-runs \
     -H "Content-Type: application/json" \
     -d '{
           "name": "My Updated Test",
           "image": "my-test-image:latest",
           "commands": ["npm", "test"]
         }'
```

This will create a new test run with the updated settings.

For more details on the available API endpoints, please refer to the [Kubernetes Integration Guide](../backend/KUBERNETES.md).
