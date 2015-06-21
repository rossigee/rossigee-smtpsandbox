# Sets up an SMTP service that delivers all mail to a Maildir
class smtpsandbox {
    $_config = hiera_hash('profile')
    $config = $_config['smtpsandbox']

    package { ['postfix', 'postfix-pcre', 'make', 'mailutils']:
        ensure => installed,
    }
    
    service { "postfix":
        ensure => "running",
        enable => "true",
        require => Package['postfix'],
        notify  => Exec["restart_postfix"],
    }
        
    file { "/etc/postfix/main.cf":
        owner => root,
        group => root,
        mode => 644,
        content => template("smtpsandbox/main.cf.erb"),
        require => Package['postfix'],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/aliases":
        owner => root,
        group => root,
        mode => 644,
        content => template("smtpsandbox/aliases.erb"),
        require => Package['postfix'],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/recipient_canonical_map":
        owner => root,
        group => root,
        mode => 644,
        content => template("smtpsandbox/recipient_canonical_map.erb"),
        require => Package['postfix'],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/Makefile":
        owner => root,
        group => root,
        mode => 644,
        source => "puppet:///modules/smtpsandbox/Makefile",
        require => Package['postfix'],
        notify  => Service["postfix"],
    }

    exec { 'restart_postfix':
        path => "/usr/bin:/bin:/usr/sbin:/sbin",
        command => "make -C /etc/postfix",
        refreshonly => true,
    }
}
