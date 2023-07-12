FROM golang:alpine as builder

RUN apk add --no-cache \
	git

WORKDIR /app

ARG COMMIT=latest

RUN GOBIN=/app go install github.com/shoopea/smtprelay@$COMMIT

FROM alpine:latest  

RUN apk add --no-cache \
    libstdc++

WORKDIR /app/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/smtprelay .

# Command to run the executable
CMD ["./smtprelay"] 
