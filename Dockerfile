FROM python:slim as build

# requirements for build
WORKDIR /sphinx
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# build html
RUN sphinx-build -M html index build/temp/index && \
    mv build/temp/index/html build/html && \
    sphinx-build -M html checklist build/temp/checklist && \
    mv build/temp/checklist/html build/html/checklist && \
# delete build info and modify sitemap
    rm build/html/.buildinfo build/html/checklist/.buildinfo build/html/objects.inv build/html/checklist/objects.inv && \
    awk -F'</urlset>' '{printf $1}' build/html/sitemap.xml > build/sitemap.xml && \
    awk -F'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' '{printf $2}' build/html/checklist/sitemap.xml >> build/sitemap.xml && \
    mv build/sitemap.xml build/html/sitemap.xml && rm build/html/checklist/sitemap.xml 

FROM nginx:stable-alpine
COPY --from=build /sphinx/build/html /var/www/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf