function life(Food,Cells)

%Generate food
Foodx=randi([0 1000],1,Food);
Foody=randi([0 1000],1,Food);
scatter(Foodx,Foody);

%Generate cells
Cellmat=zeros(3,Cells);
Cellmat(3,:)=5;
Cellmat(
end