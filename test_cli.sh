echo 'mkdir /ngs && cd /ngs'
mkdir /ngs && cd /ngs

#echo 'TEST: Download distr'
wget http://ngb.opensource.epam.com/distr/2.3/catgenome-2.3.jar
wget http://ngb.opensource.epam.com/distr/2.3/ngb-cli-2.3.tar.gz

#echo 'TEST: Download data'
wget http://ngb.opensource.epam.com/distr/data/genome/dm6/dmel-all-chromosome-r6.06.fasta
wget http://ngb.opensource.epam.com/distr/data/genome/dm6/dmel-all-chromosome-r6.06.fasta.fai

echo 'mv catgenome-2.3.jar catgenome.jar'
mv catgenome-2.3.jar catgenome.jar

echo 'tar -zxvf ngb-cli-2.3.tar.gz'
tar -zxvf ngb-cli-2.3.tar.gz

echo 'nohup java -Xmx3Gb -jar catgenome.jar &'
nohup java -Xmx3G -jar catgenome.jar &

echo 'sleep 30'
sleep 30

echo 'cat nohup.out'
cat nohup.out

echo 'cd /ngs/ngb-cli/bin'
cd /ngs/ngb-cli/bin

echo './ngb reg_ref /ngs/dmel-all-chromosome-r6.06.fasta --name dm6'
./ngb reg_reg /ngs/dmel-all-chromosome-r6.06.fasta --name dm6

echo './ngb lr -t'
./ngb lr -t
