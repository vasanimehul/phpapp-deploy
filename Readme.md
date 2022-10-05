# Welcome to the Apache template for TinyStacks!

Build the image with:
```
docker build -t php-tinystacks .
```

Then run the container based on the image:
```
docker run -p 8080:8080 -d --name phpapp php-tinystacks
```

Visit localhost:80 in your browser.