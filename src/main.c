/**
 * @file main.c
 * @author Hanjae Lee (mail@hanjaelee.com)
 * @date 2026-01-28 23:52
 */

#define PORT 8100

#include <stdio.h>

#include "ecewo.h"
#include "ecewo-static.h"
#include "controller.h"

int main(void) {
    if (server_init() != 0) {
        fprintf(stderr, "Failed to initialize server\n");
        return -1;
    }

    // Initialize static file serving module
    // (automatically initializes ecewo-fs internally)
    if (static_init() != 0) {
        fprintf(stderr, "Failed to initialize static module\n");
        return 1;
    }

    // Serve ./public directory at root URL
    if (serve_static("/public", "./public", NULL) != 0) {
        fprintf(stderr, "Failed to mount static directory\n");
        return 1;
    }

    get("/", index_controller);
    get("/write", write_controller);
    get("/ping", ping);

     // Register cleanup handler (also cleans up fs module)
    server_atexit(static_cleanup);

    if (server_listen(PORT) != 0) {
        fprintf(stderr, "Failed to start server\n");
        return -1;
    }

    server_run();
    return 0;
}
