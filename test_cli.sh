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

echo 'nohup java -Xmx3G -jar catgenome.jar &'
nohup java -Xmx3G -jar catgenome.jar &

echo 'sleep 30'
sleep 30

echo 'cat nohup.out'
cat nohup.out

echo 'cd /ngs/ngb-cli/bin'
cd /ngs/ngb-cli/bin

echo './ngb reg_ref /ngs/dmel-all-chromosome-r6.06.fasta --name dm6'
./ngb reg_ref /ngs/dmel-all-chromosome-r6.06.fasta --name dm6

echo './ngb lr -t'
./ngb lr -t

echo './ngb reg_dataset dm6 dm1'
./ngb reg_dataset dm6 dm1

echo './ngb reg_dataset dm6 dm1_1 -p dm1'
./ngb reg_dataset dm6 dm1_1 -p dm1

echo './ngb reg_dataset dm6 dm1_2 -p dm1'
./ngb reg_dataset dm6 dm1_2 -p dm1

echo './ngb reg_dataset dm6 dm2'
./ngb reg_dataset dm6 dm2

echo './ngb reg_dataset dm6 dm2_1 -p dm2'
./ngb reg_dataset dm6 dm2_1 -p dm2

echo './ngb reg_dataset dm6 dm2_2 -p dm2'
./ngb reg_dataset dm6 dm2_2 -p dm2

echo './ngb ld -t'
./ngb ld -t

echo './ngb ld -p dm1 -t'
./ngb ld -p dm1 -t

echo './ngb ld -p dm2 -t'
./ngb ld -p dm2 -t


