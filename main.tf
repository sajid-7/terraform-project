#this file consists of code for instances and sg
provider "aws" {
region = "ap-northeast-1"
access_key = "AKIA5KJL4GTN2YRONJPM"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-030cf0a1edb8636ab"
  instance_type   = "t2.micro"
  key_name        = "sk"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SK Weather app</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  </head>
  <body>
    <nav class="navbar navbar-expand-lg bg-info bg-gradient
    ">
      
      <div class="container-fluid">
        <a class="navbar-brand" href="#">Weather App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="#">Home-2</a>
            </li>
            
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                How to use
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Action</a></li>
                <li><a class="dropdown-item" href="#">Another action</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="#">how to use</a></li>
              </ul>
            </li>
            
          </ul>
          <form class="d-flex" role="search">
            <input id="city" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="submit" id="submit">Search</button>
          </form>
        </div>
      </div>
    </nav>

    <div class="container ">

      <div class="container">
          <h1 class= "my-4 text-center">Weather for <span id="cityName"></span></h1>



      <main>
        <div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
          <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
              <div class="card-header py-3 text-bg-info bg-gradient border-primary">
                <h4 class="my-0 fw-normal">Temperature</h4>
              </div>
              <div class="card-body">
                <h1 class="card-title pricing-card-title"><svg class="icon" data-src="/images/weathericons/35.svg" viewBox="0 0 288 288" width="62" height="62"><g stroke-width="8.792" fill="none" fill-rule="evenodd"><path d="M136.323 121.88a100.498 100.498 0 0 1 16.398-80.978 103.839 103.839 0 0 0-86.782 121.731M93.943 216.003a104.718 104.718 0 0 0 163.672-17.98 102.564 102.564 0 0 1-61.943-5.496" stroke="#686763" stroke-linejoin="bevel"></path><path d="M159.095 135.596h-5.407c-12.979-16.162-34.666-22.506-54.309-15.886-19.643 6.62-33.066 24.796-33.615 45.517h-7.87a25.41 25.41 0 1 0 0 50.776h101.114a40.225 40.225 0 1 0 0-80.407h.087Z" stroke="#BABABA"></path></g></svg><SPAN id="temp2"></SPAN><small class="text-muted fw-light">°C</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                  <li>Temperature is <SPAN id="temp"></SPAN></li>
                  <li>Min Temperature is <SPAN id="min_temp"></SPAN></li>
                  <li>Max Temperature is <SPAN id="max_temp"></SPAN></li>
                  

                </ul>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
              <div class="card-header py-3 text-bg-info bg-gradient border-primary">
                <h4 class="my-0 fw-normal">Humidity</h4>
              </div>
              <div class="card-body">
                <h1 class="card-title pricing-card-title"><SPAN id="humidity2"></SPAN><small class="text-muted fw-light">%</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                  
                  <li>Humidity <SPAN id="humidity"></SPAN></li>
                  <li>Feels Like <SPAN id="feels_like"></SPAN></li>
                  <li>Wind Degree is <SPAN id="wind_degrees"></SPAN></li>

                </ul>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
              <div class="card-header py-3 text-bg-info bg-gradient border-primary">
                <h4 class="my-0 fw-normal">Wind Info</h4>
              </div>
              <div class="card-body">
                <h1 class="card-title pricing-card-title"><SPAN id="wind_speed2"></SPAN><small class="text-muted fw-light">km/hr</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                  
                  <li>Wind Speed is <SPAN id="wind_speed"></SPAN></li>
                  <li>Sunrise Time is <SPAN id="sunrise"></SPAN></li>
                  <li>Sunset Time is <SPAN id="sunset"></SPAN></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
    
        <h2 class="display-6 text-center mb-4">Weather Of Other Places</h2>
    
        <div class="table-responsive">
          <table class="table text-center">
            <thead>
              <tr>
                <th style="width: 0%;">Country</th>
                
                <th style="width: 22%;">Temperature</th>
                <th style="width: 22%;">Humidity</th>
                <th style="width: 22%;">Wind Info</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row" class="text-start">Dubai</th>
                <td><span id="temp3"></span></td>
                <td><span id="humidity3"></span></td>
                <td><span id="wind_speed3"></span></td>
                
                
                
              </tr>
              <tr>
                <th scope="row" class="text-start">England</th>
                <td><span id="temp4"></span></td>
                <td><span id="humidity4"></span></td>
                <td><span id="wind_speed4"></span></td>  
              </tr>
            </tbody>
    
            <tbody>
              <tr>
                <th scope="row" class="text-start">Japan</th>
                <td><span id="temp5"></span></td>
                <td><span id="humidity5"></span></td>
                <td><span id="wind_speed5"></span></td></tr>
              <tr>
                <th scope="row" class="text-start">Spain</th>
                <td><span id="temp6"></span></td>
                <td><span id="humidity6"></span></td>
                <td><span id="wind_speed6"></span></td>
              </tr>
              
            </tbody>
          </table>
        </div>
      </main>
    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="script.js"></script>
  </body>
</html>" > /var/www/html/index.html
echo "
EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-030cf0a1edb8636ab"
  instance_type   = "t2.micro"
  key_name        = "sk"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-1c"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SK Weather app</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  </head>
  <body>
    <nav class="navbar navbar-expand-lg bg-info bg-gradient
    ">
      
      <div class="container-fluid">
        <a class="navbar-brand" href="#">Weather App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="#">Home</a>
            </li>
            
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                How to use
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Action</a></li>
                <li><a class="dropdown-item" href="#">Another action</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="#">how to use</a></li>
              </ul>
            </li>
            
          </ul>
          <form class="d-flex" role="search">
            <input id="city" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="submit" id="submit">Search</button>
          </form>
        </div>
      </div>
    </nav>

    <div class="container ">

      <div class="container">
          <h1 class= "my-4 text-center">Weather for <span id="cityName"></span></h1>



      <main>
        <div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
          <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
              <div class="card-header py-3 text-bg-info bg-gradient border-primary">
                <h4 class="my-0 fw-normal">Temperature</h4>
              </div>
              <div class="card-body">
                <h1 class="card-title pricing-card-title"><svg class="icon" data-src="/images/weathericons/35.svg" viewBox="0 0 288 288" width="62" height="62"><g stroke-width="8.792" fill="none" fill-rule="evenodd"><path d="M136.323 121.88a100.498 100.498 0 0 1 16.398-80.978 103.839 103.839 0 0 0-86.782 121.731M93.943 216.003a104.718 104.718 0 0 0 163.672-17.98 102.564 102.564 0 0 1-61.943-5.496" stroke="#686763" stroke-linejoin="bevel"></path><path d="M159.095 135.596h-5.407c-12.979-16.162-34.666-22.506-54.309-15.886-19.643 6.62-33.066 24.796-33.615 45.517h-7.87a25.41 25.41 0 1 0 0 50.776h101.114a40.225 40.225 0 1 0 0-80.407h.087Z" stroke="#BABABA"></path></g></svg><SPAN id="temp2"></SPAN><small class="text-muted fw-light">°C</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                  <li>Temperature is <SPAN id="temp"></SPAN></li>
                  <li>Min Temperature is <SPAN id="min_temp"></SPAN></li>
                  <li>Max Temperature is <SPAN id="max_temp"></SPAN></li>
                  

                </ul>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
              <div class="card-header py-3 text-bg-info bg-gradient border-primary">
                <h4 class="my-0 fw-normal">Humidity</h4>
              </div>
              <div class="card-body">
                <h1 class="card-title pricing-card-title"><SPAN id="humidity2"></SPAN><small class="text-muted fw-light">%</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                  
                  <li>Humidity <SPAN id="humidity"></SPAN></li>
                  <li>Feels Like <SPAN id="feels_like"></SPAN></li>
                  <li>Wind Degree is <SPAN id="wind_degrees"></SPAN></li>

                </ul>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
              <div class="card-header py-3 text-bg-info bg-gradient border-primary">
                <h4 class="my-0 fw-normal">Wind Info</h4>
              </div>
              <div class="card-body">
                <h1 class="card-title pricing-card-title"><SPAN id="wind_speed2"></SPAN><small class="text-muted fw-light">km/hr</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                  
                  <li>Wind Speed is <SPAN id="wind_speed"></SPAN></li>
                  <li>Sunrise Time is <SPAN id="sunrise"></SPAN></li>
                  <li>Sunset Time is <SPAN id="sunset"></SPAN></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
    
        <h2 class="display-6 text-center mb-4">Weather Of Other Places</h2>
    
        <div class="table-responsive">
          <table class="table text-center">
            <thead>
              <tr>
                <th style="width: 0%;">Country</th>
                
                <th style="width: 22%;">Temperature</th>
                <th style="width: 22%;">Humidity</th>
                <th style="width: 22%;">Wind Info</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row" class="text-start">Dubai</th>
                <td><span id="temp3"></span></td>
                <td><span id="humidity3"></span></td>
                <td><span id="wind_speed3"></span></td>
                
                
                
              </tr>
              <tr>
                <th scope="row" class="text-start">England</th>
                <td><span id="temp4"></span></td>
                <td><span id="humidity4"></span></td>
                <td><span id="wind_speed4"></span></td>  
              </tr>
            </tbody>
    
            <tbody>
              <tr>
                <th scope="row" class="text-start">Japan</th>
                <td><span id="temp5"></span></td>
                <td><span id="humidity5"></span></td>
                <td><span id="wind_speed5"></span></td></tr>
              <tr>
                <th scope="row" class="text-start">Spain</th>
                <td><span id="temp6"></span></td>
                <td><span id="humidity6"></span></td>
                <td><span id="wind_speed6"></span></td>
              </tr>
              
            </tbody>
          </table>
        </div>
      </main>
    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="script.js"></script>
  </body>
</html>" > /var/www/html/index.html

EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "four" {
  bucket = "myapnortheastb"
}

resource "aws_iam_user" "five" {
name = "rahamuser11" 
}

resource "aws_ebs_volume" "six" {
 availability_zone = "ap-northeast-1c"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
