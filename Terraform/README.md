# Despliegue de Nginx en ECS con ALB usando Terraform

## Descripción
Este proyecto despliega una aplicación Nginx en un clúster de **ECS** utilizando un **Application Load Balancer (ALB)** en AWS. El despliegue está dividido en dos módulos principales: **ALB** y **ECS**.

## Instrucciones

### **1. Despliegue del Módulo ALB**
Primero, necesitamos desplegar el módulo **ALB**. Este módulo creará el **Application Load Balancer (ALB)** y un **Target Group** que se usará para enrutar el tráfico hacia la aplicación Nginx.

#### Comandos para desplegar el módulo ALB:

```bash
cd alb
terraform init
terraform apply
```
### **2. Copiar el ARN del Target Group**

Una vez desplegado el módulo ALB, Terraform generará un output con el ARN del Target Group. Copia este ARN, ya que lo necesitaremos para configurar el módulo ECS.

El ARN del Target Group debería verse así:

```bash
arn:aws:elasticloadbalancing:eu-west-1:xxxxxxxxxxxx:targetgroup/nginx-alb-dev-sonia-tg/xxxxxxxxxxxx
```
### **3. Configuración del Módulo ECS**
Ahora, edita el archivo main.tf del módulo ECS y pega el ARN del Target Group copiado en el paso anterior en el campo target_group_arn.

```bash
load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:xxxxxxxxxxxx:targetgroup/nginx-alb-dev-sonia-tg/xxxxxxxxxxxx"
    container_name   = "nginx"
    container_port   = 80
  }
```
### **4. Despliegue del Módulo ECS**
Después de haber actualizado el archivo main.tf en el módulo ECS, despliega el clúster ECS.

Comandos para desplegar el módulo ECS:
```bash
cd ecs
terraform init
terraform apply
```
### **5. Verificación**

Una vez desplegados ambos módulos, puedes acceder a la aplicación Nginx usando el DNS del ALB, que fue generado como parte del output del módulo ALB.

Para obtener el DNS del ALB, puedes verificar el output de Terraform o acceder a la consola de AWS, sección Load Balancers.

Por ejemplo, el DNS se verá algo así:

```bash
nginx-alb-sonia-xxxxxxxxx.eu-west-1.elb.amazonaws.com
```
Accede a este DNS en el navegador para probar tu aplicación Nginx.