FROM python:3.10 as build

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "core.wsgi:application"]

FROM nginx:stable-alpine

COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]