FROM ortussolutions/commandbox:lucee5

WORKDIR /app
COPY ../app ./

# Install dependencies
RUN box install

EXPOSE 8080