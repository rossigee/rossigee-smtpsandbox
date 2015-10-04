# Puppet module for a postfix instance that doesn't relay mail externally

## Example hiera config

```
profile:
    smtpsandbox:
        default_recipient: root@mydomain.com
        whitelist_addresses:
            - root@mydomain.com
            - test1@mydomain.com
            - test2@mydomain.com
        whitelist_domains:
            - mytestdomain.com
```


