compile: 
	gcc -o server server.c -lm -lpthread
	gcc -o client client.c


runserver :
	./server 8888


runclient:
	./client 127.0.0.1 8888 0.2 Transactions.txt

clean :
	rm server client
