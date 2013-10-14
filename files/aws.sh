export EC2_HOME=/opt/aws
for i in $EC2_HOME
do
  PATH=$i/bin:$PATH
done
PATH=/opt/aws/:$PATH
