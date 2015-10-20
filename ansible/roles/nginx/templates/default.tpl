server {
    listen  80;

    root {{ nginx.docroot }};
    index index.html index.php {{ nginx.docindex }};

    server_name {{ nginx.servername }};

    sendfile off;

    fastcgi_buffers 8 16k;
    fastcgi_buffer_size 32k;

    access_log /var/log/nginx/symfony.access.log;
    error_log /var/log/nginx/symfony.error.log;

    location / {
        try_files $uri $uri/ /{{ nginx.docindex }}?$query_string;
    }

    error_page 404 /404.html;

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        root /usr/share/nginx/www;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index {{ nginx.docindex }};
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
