## Building source code using builder stage  
FROM golang:alpine AS builder
ADD ./ /src

# Adding required dependencies to build appliaction 
RUN apk update --no-cache \
	&& apk add git gcc libc-dev
# Generating build
RUN cd /src \
	&& go build -o golang-test  .
    		
## Creating final image to run the application 
FROM alpine
ENV GO111MODULE=on
WORKDIR /app
# Copying build generated in the previous stage "builder" 
COPY --from=builder /src/golang-test /app/
ENTRYPOINT ["/app/golang-test"]
EXPOSE 8000
