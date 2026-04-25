#ifndef _NET_NET_H
#define _NET_NET_H
#include <stdint.h>
#include <stddef.h>
typedef uint32_t ip4_addr_t;
typedef struct { ip4_addr_t addr, netmask, gateway, dns[2]; } ip4_config_t;
typedef struct netif {
    char name[16];
    uint8_t mac[6];
    ip4_config_t ip_cfg;
    void *driver_data;
    int (*send)(struct netif *netif, const void *data, size_t len);
    struct netif *next;
} netif_t;
#define IP4(a,b,c,d) ((ip4_addr_t)((a)<<24|(b)<<16|(c)<<8|(d)))
netif_t *netif_get_default(void);
int netif_register(netif_t *netif);
void net_init(void);
void netif_list(void);
void net_dump_stats(void);
void dns_set_server(ip4_addr_t);
int dns_resolve(const char *, ip4_addr_t *);
int dhcp_discover(void);
int icmp_ping(ip4_addr_t, uint16_t, uint16_t);
const char *ip4_to_str(ip4_addr_t);
void arp_dump_cache(void);
#endif