# OHIF Viewer Development with Hot Reloading

This guide explains how to run the OHIF viewer with hot reloading enabled in Docker.

## Development Setup (with Hot Reloading)


1. **Start the development environment**
   ```bash
   docker-compose -f docker-compose.dev.yml up --build
   ```

2. **Access the application:**
   - OHIF Viewer: http://localhost/oirrc-viewer/
   - Webpack Dev Server (direct): http://localhost:3000
   - Orthanc PACS: http://localhost:8042
   - Keycloak: http://localhost/keycloak/

3. **Make changes to your code:**
   - Edit any file in the `extensions/`, `modes/`, or `platform/` directories
   - The webpack dev server will automatically detect changes
   - Your browser will hot reload with the changes (usually within 1-2 seconds)

4. **Stop the environment:**
   ```bash
   docker-compose -f docker-compose.dev.yml down
   ```

### How It Works

The development setup uses:
- **Volume mounting**: Your source code is mounted into the container, so changes are immediately visible
- **Webpack Dev Server**: Running inside the container with hot module replacement (HMR)
- **Nginx reverse proxy**: Routes traffic to the webpack dev server and handles authentication
- **Node modules isolation**: `node_modules` is kept inside the container to avoid conflicts

### Key Differences from Production

| Feature | Development | Production |
|---------|------------|------------|
| Build time | No initial build needed | Full build required |
| Code changes | Instant hot reload | Requires rebuild |
| File serving | Webpack dev server | Static files from Nginx |
| Performance | Slower (development mode) | Optimized (production mode) |
| Volume mounts | Source code mounted | Only config files mounted |

### Tips for Development

1. **First time setup may take longer** as dependencies are installed
2. **Subsequent starts are faster** since dependencies are cached
3. **Keep the terminal open** to see webpack compilation logs
4. **If hot reload stops working**, restart the container:
   ```bash
   docker-compose -f docker-compose.dev.yml restart oirrc_viewer
   ```

### Troubleshooting

**Changes not reflecting?**
- Check the webpack dev server logs in the terminal
- Ensure you're editing files in the correct location
- Try a hard refresh (Ctrl+Shift+R or Cmd+Shift+R)

**Container keeps restarting?**
- Check the logs: `docker-compose -f docker-compose.dev.yml logs oirrc_viewer`
- Ensure all dependencies are properly installed
- Try rebuilding: `docker-compose -f docker-compose.dev.yml up --build --force-recreate`

**Port conflicts?**
- Make sure port 3000 is not in use by another application
- You can change the port in `docker-compose.dev.yml`

## Production Setup (Original)

For production deployment without hot reloading:

```bash
docker-compose up --build
```

This will:
- Build the application once
- Serve static files through Nginx
- Provide better performance for production use

## Switching Between Modes

- **Development**: `docker-compose -f docker-compose.dev.yml up`
- **Production**: `docker-compose up`

You can run both simultaneously if you change the ports in one of them.

## Additional Commands

**View logs:**
```bash
docker-compose -f docker-compose.dev.yml logs -f oirrc_viewer
```

**Rebuild without cache:**
```bash
docker-compose -f docker-compose.dev.yml build --no-cache
docker-compose -f docker-compose.dev.yml up
```

**Clean up everything**
```bash
docker-compose -f docker-compose.dev.yml down -v
```
