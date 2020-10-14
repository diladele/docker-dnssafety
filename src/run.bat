docker run -dt --name dnssafety -p 8000:8000 -p 53:53 -p 80:80 -p 443:443 -v dnssafety_etc:/opt/dnssafety/etc -v dnssafety_var:/opt/dnssafety/var diladele/dnssafety:0.16
