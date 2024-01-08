FROM alpine:latest
COPY midori_shibukawa /midori_shibukawa 
EXPOSE 8080
CMD [ "sh", "-c", "/midori_shibukawa" ]
