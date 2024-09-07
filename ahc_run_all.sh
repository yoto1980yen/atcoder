for i in $(seq -f '%04g' 0 99)
do
	ruby ahc/ahc036/a.rb < ./in/${i}.txt > out/${i}.txt
done