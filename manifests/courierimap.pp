# Sets up an IMAP service allowing collection of sandboxed mail
class smtpsandbox::courierimap {
    package { 'courier-imap-ssl':
        ensure => installed,
    }
    
    service { 'courier-imap-ssl':
        ensure => running,
    }
}
