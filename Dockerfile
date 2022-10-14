FROM rocker/shiny:4.2
# Install system requirements for index.R as needed
#ENV _R_SHLIB_STRIP_=true
#COPY Rprofile.site /etc/R
#RUN install2.r --error --skipinstalled \
#    shiny \
#    forecast \
#    jsonlite \
#    ggplot2 \
#    htmltools \
#    plotly
COPY ./app/* /srv/shiny-server/
COPY ./start.sh /start.sh
RUN sed -i -e's/^run_as.*$/run_as default;/' /etc/shiny-server/shiny-server.conf
RUN chgrp -R root /etc/passwd /var/log/shiny-server /var/lib/shiny-server
RUN chmod -R g+w /etc/passwd /var/log/shiny-server /var/lib/shiny-server
RUN chmod +x /start.sh
#USER shiny
EXPOSE 3838
CMD ["/start.sh"]
