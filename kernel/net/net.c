/* ============================================================================
 *  EarlnuxOS - Network Stack Stub
 * kernel/net/net.c
 * ============================================================================ */

#include <net/net.h>
#include <kernel/kernel.h>
#include <stddef.h>

static netif_t *default_netif = NULL;

void net_init(void) {
    KINFO("net", "Network stack initialization (stub)");
}

void net_dump_stats(void) {
    kprintf("Network stats: stub implementation\n");
}

netif_t *netif_get_default(void) {
    return default_netif;
}

int netif_register(netif_t *netif) {
    if (!netif) return -1;

    // Add to linked list and set as default if first
    static netif_t *list = NULL;
    netif->next = list;
    list = netif;

    if (!default_netif) {
        default_netif = netif;
    }

    return 0;
}

int netif_send(netif_t *netif, const void *data, size_t len) {
    if (!netif || !netif->send) return -1;
    return netif->send(netif, data, len);
}