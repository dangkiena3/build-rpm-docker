yum -y install  pcre pcre-devel  rsyslog zip unzip gcc gcc-c++ openssl openssl-devel zlib gd freetype freetype-devel autoconf openldap openldap-devel bzip2-devel libpng libpng-devel libjpeg libjpeg-devel perl-ExtUtils-Embed



##########################################
##########Compile Nginx with options######
##########################################


NGINX_RELEASE_VERSION="1.12.2"
OWNER_RELEASE_TIME="1"
VERSION="${NGINX_RELEASE_VERSION}.${OWNER_RELEASE_TIME}"
mkdir -p /tmp/builder/nginx/src
#cp /build/BUILDS/NGINX/SRC/nginx-${NGINX_RELEASE_VERSION}.tar.gz /tmp/builder/nginx/src
cd /build/BUILDS/NGINX/SRC/
#tar -zxvf nginx-${NGINX_RELEASE_VERSION}.tar.gz
#tar -zxvf echo-nginx-module.tar.gz
#tar -zxvf nginx-rtmp-module.tar.gz
#tar -zxvf ngx_http_redis.tar.gz
#tar -zxvf openssl-1.1.0f.tar.gz
#tar -zxvf zlib-1.2.11.tar.gz
#tar -zxvf pcre-8.40.tar.gz
cd nginx-${NGINX_RELEASE_VERSION}

./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/nginx/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --without-http_split_clients_module --without-http_uwsgi_module --without-http_scgi_module --with-openssl=../openssl-1.1.0f --with-http_realip_module --with-http_secure_link_module --with-http_dav_module --with-http_stub_status_module --with-pcre=../pcre-8.40 --with-http_geoip_module --with-zlib=../zlib-1.2.11 --with-http_gzip_static_module --with-debug --with-file-aio --with-http_mp4_module --with-http_addition_module --with-http_v2_module --with-stream --with-stream_ssl_preread_module --with-http_perl_module --with-ld-opt="-Wl,-E" --add-module=../ngx_http_redis --with-http_ssl_module --with-http_stub_status_module --add-module=../nginx-rtmp-module --add-module=../echo-nginx-module


make
make install


cd ..
rm -rfv /tmp/builder/nginx/src

cp /build/BUILDS/NGINX/SRC/nginx.init /etc/init.d/nginx
chmod +x /etc/init.d/nginx
#Compile DONE, you should check if Nginx is starting OK



##############################################
#			Prepare to Build RPM             #
##############################################


mkdir -p /tmp/builder/nginx/build

cd /tmp/builder/nginx/build

mkdir -p usr/local/nginx usr/local/nginx/sbin var/log/nginx etc/init.d/ usr/local/lib64/perl5/auto/nginx/ /lib64/ usr/local/nginx/conf.d/nossl/ usr/local/nginx/conf.d/ssl/ usr/local/nginx/conf.d/params/ lib64 /usr/local/nginx/conf.d/nossl /usr/local/nginx/conf.d/ssl /usr/local/nginx/conf.d/params
rsync -avz /usr/local/nginx/. usr/local/nginx
rsync -avz /usr/local/nginx/sbin/nginx usr/local/nginx/sbin/nginx
rsync -avz /etc/init.d/nginx etc/init.d/nginx
rsync -avz /usr/local/lib64/perl5/auto/nginx/. usr/local/lib64/perl5/auto/nginx/
rsync -avz /usr/local/lib64/perl5/nginx.pm usr/local/lib64/perl5/nginx.pm
rsync -avz /lib64/libGeoIP.so.1 lib64/libGeoIP.so.1
rsync -avz /usr/local/nginx/conf.d/nossl/ usr/local/nginx/conf.d/nossl/
rsync -avz /usr/local/nginx/conf.d/ssl/ usr/local/nginx/conf.d/ssl/
rsync -avz /usr/local/nginx/conf.d/params/ usr/local/nginx/conf.d/params/


##############################################
#			    Build RPM                    #
##############################################

fpm -s dir -t rpm -n nginx -v ${VERSION} -p nginx-VERSION.rpm --url "https://appota.com" --description "Nginx ${VERSION}" --vendor "Kiennd" -d pcre -d pcre-devel  -d zip -d unzip -d gcc -d gcc-c++ -d openssl -d openssl-devel -d zlib -d gd -d freetype -d freetype-devel -d autoconf -d openldap -d openldap-devel -d bzip2-devel -d libpng -d libpng-devel -d libjpeg -d libjpeg-devel -d perl-ExtUtils-Embed -d GeoIP -d GeoIP-devel usr etc var lib64

cp nginx-${VERSION}.rpm /build/RPMS

##############################################
#			    Clean everything                    #
##############################################
rm -rf usr etc var 
rm -rfv /tmp/builder/nginx/build
