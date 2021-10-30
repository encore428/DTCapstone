## Push Application Change to Github

Modify the app by adding ` (more text)` to "text" of the first record in `db.json`, and push the change to github.

```
{
  "todos": [
    {
      "id": 1,
      "text": "Align Engine Output (more text)",
      "type": "long"
    },

```

Workflow executed successfully:
![github workflow in action](./img/cicd2.png)

ECR has an updated image
![ECR new image tag](./img/ecr3.png)
