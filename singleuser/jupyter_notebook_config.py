c = get_config()
c.NotebookApp.ip = '*'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False
c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy':
        "frame-ancestors 'self' http://localhost:8080"
    }
}
