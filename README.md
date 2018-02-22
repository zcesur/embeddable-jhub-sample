# Embeddable JupyterHub on Kubernetes

The default setup of both Jupyter Hub and single-user Jupyter Notebook/Lab server is configured to prohibit outside domains from embedding the page. As a workaround, we can include our domain(s), say `http://localhost:8080`, in the frame-ancestors directive:

```yaml
# config.yaml

hub:
  extraConfig: |
    c.JupyterHub.tornado_settings = {'headers': {'Content-Security-Policy': "frame-ancestors 'self' http://localhost:8080"}}
```

Nevertheless, this much configuration is not sufficient as our visitors would still encounter the "Blocked by Content Security Policy" error after they are redirected to a notebook/lab page even though they can now use the hub homepage. Although this may not be the best solution, the workaround that I came up with was to re-build the Dockerfile of the single-user Jupyter notebook server with the same settings as above, and then use this image in the Helm configuration:

```python
# singleuser/jupyter_notebook_config.py

c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy':
        "frame-ancestors 'self' http://localhost:8080"
    }
}
```

```yaml
# config.yaml

hub:
  extraConfig: |
    c.JupyterHub.spawner_class = 'kubespawner.KubeSpawner'
    c.KubeSpawner.singleuser_image_spec = 'zcesur/jupyter-singleuser'
```

## References

- https://github.com/jupyterhub/jupyterhub/issues/379
- https://github.com/jupyterhub/zero-to-jupyterhub-k8s
