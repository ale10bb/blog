FROM python:slim as build

# requirements for build
WORKDIR /sphinx
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# build html
RUN sphinx-build -M html index _build/temp/index && \
    mv _build/temp/index/html _build/html && \
    sphinx-build -M html checklist _build/temp/checklist && \
    mv _build/temp/checklist/html _build/html/checklist && \
# delete build info and modify sitemap
    rm _build/html/.buildinfo _build/html/checklist/.buildinfo _build/html/objects.inv _build/html/checklist/objects.inv && \
    awk -F'</urlset>' '{printf $1}' _build/html/sitemap.xml > _build/sitemap.xml && \
    awk -F'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' '{printf $2}' _build/html/checklist/sitemap.xml >> _build/sitemap.xml && \
    mv _build/sitemap.xml _build/html/sitemap.xml && rm _build/html/checklist/sitemap.xml 

FROM nginx:stable-alpine
COPY --from=build /sphinx/build/_html /var/www/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf