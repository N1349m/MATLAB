function result = quadrilateral(v)
 
    vectors = v-circshift(v,1);
    lengths = sqrt(sum(vectors.^2,2));
    cosines = sum(vectors.*circshift(vectors,1),2)./lengths./circshift(lengths,1);
 
    equallengths = all(lengths==circshift(lengths,1));
    equalangles = all(cosines==circshift(cosines,1));
 
    if (equallengths)
        if(equalangles)
            result = 'square';
        else
            result = 'rhombus';
        end
    else
        if(equalangles)
            result = 'rectangle';
        else
            result = 'quadrilateral';
        end
    end
end