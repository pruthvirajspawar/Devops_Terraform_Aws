resource "aws_instance" "servers" {

  for_each = var.instances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = var.key_name

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
#!/bin/bash

dnf update -y
dnf install nginx -y

systemctl enable nginx
systemctl start nginx

cat > /usr/share/nginx/html/index.html << 'HTML'

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pruthviraj Pawar | AWS & DevOps Engineer</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,Helvetica,sans-serif;
}

body{
    background:#0f172a;
    color:white;
}

header{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    text-align:center;
    background:linear-gradient(135deg,#0f172a,#1e3a8a,#2563eb);
}

.hero h1{
    font-size:55px;
}

.hero h1 span{
    color:#38bdf8;
}

.hero h2{
    margin:15px 0;
    font-size:28px;
    color:#e2e8f0;
}

.hero p{
    max-width:700px;
    margin:auto;
    font-size:18px;
    line-height:1.7;
    color:#cbd5e1;
}

.btn{
    display:inline-block;
    margin-top:30px;
    padding:15px 35px;
    background:#38bdf8;
    color:#000;
    text-decoration:none;
    font-weight:bold;
    border-radius:30px;
    transition:.3s;
}

.btn:hover{
    transform:scale(1.08);
    background:white;
}

section{
    padding:70px 10%;
}

h2{
    text-align:center;
    margin-bottom:40px;
    color:#38bdf8;
    font-size:35px;
}

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
}

.card{
    background:#1e293b;
    padding:25px;
    border-radius:15px;
    transition:.4s;
}

.card:hover{
    transform:translateY(-10px);
    background:#2563eb;
}

.card h3{
    margin-bottom:15px;
}

footer{
    background:#020617;
    text-align:center;
    padding:25px;
    color:#94a3b8;
}
</style>

</head>

<body>

<header>
<div class="hero">
<h1>Hello, I'm <span>Pruthviraj Pawar</span></h1>

<h2>AWS Cloud & DevOps Engineer</h2>

<p>
Passionate about Cloud Computing, AWS, Terraform, Docker,
Kubernetes, Jenkins, GitHub Actions, Linux and CI/CD Automation.
I enjoy building scalable cloud infrastructure and automating deployments.
</p>

<a href="#skills" class="btn">Explore</a>

</div>
</header>

<section id="skills">

<h2>Technical Skills</h2>

<div class="cards">

<div class="card">
<h3>☁ AWS</h3>
<p>EC2, VPC, IAM, S3, RDS, Route53, CloudWatch, Auto Scaling, Load Balancer</p>
</div>

<div class="card">
<h3>⚙ DevOps</h3>
<p>Terraform, Docker, Kubernetes, Jenkins, GitHub Actions, CI/CD</p>
</div>

<div class="card">
<h3>💻 Operating System</h3>
<p>Linux Administration, Shell Scripting, Networking Basics</p>
</div>

<div class="card">
<h3>🛠 Programming</h3>
<p>Python, HTML, CSS, Git, GitHub</p>
</div>

</div>

</section>

<section>

<h2>Projects</h2>

<div class="cards">

<div class="card">
<h3>Terraform AWS Infrastructure</h3>
<p>
Provisioned complete AWS infrastructure using Terraform modules,
including VPC, EC2, Security Groups and Networking.
</p>
</div>

<div class="card">
<h3>CI/CD Pipeline</h3>
<p>
Implemented automated deployment using GitHub Actions,
Docker and AWS.
</p>
</div>

<div class="card">
<h3>Static Website Hosting</h3>
<p>
Hosted responsive website on Amazon S3 with CloudFront
for fast global delivery.
</p>
</div>

</div>

</section>

<section>

<h2>Contact</h2>

<div class="cards">

<div class="card">
<h3>Email</h3>
<p>your-email@example.com</p>
</div>

<div class="card">
<h3>GitHub</h3>
<p>github.com/yourusername</p>
</div>

<div class="card">
<h3>LinkedIn</h3>
<p>linkedin.com/in/yourprofile</p>
</div>

</div>

</section>

<footer>

<h3>© 2026 Pruthviraj Pawar | AWS & DevOps Engineer</h3>

</footer>

</body>
</html>

HTML

systemctl restart nginx

EOF

  tags = {
    Name = each.value.name
  }

}