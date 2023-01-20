resource "aws_instance" "Front_Instance" {    
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.FrontSecurityGroup.id]
   
    tags = {
        Name  = "Front_Instance_terraform"
        Owner = "DOS-11-Student"        
    }
}

resource "aws_instance" "BackEnd_Instance_1" {    
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.BackEndSecurityGroup.id]
   
    tags = {
        Name  = "BackEnd_Instance_terraform-1"
        Owner = "DOS-11-Student"        
    }
}

resource "aws_instance" "BackEnd_Instance_2" {    
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.BackEndSecurityGroup.id]
   
    tags = {
        Name  = "BackEnd_Instance_terraform-2"
        Owner = "DOS-11-Student"        
    }
}