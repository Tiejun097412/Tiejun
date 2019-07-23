function Cpoint = Controlpoint(P,d)
Cpoint = zeros(2,length(P));
for i = 2 : 1 : length(P)-1
   if P(1,i) == P(1,i+1)
       Cpoint(1,i) = P(1,i)*ones(abs(P(2,i+1)-P(2,i))/d);
       if P(2,i) > P(2,i+1)
           Cpoint(2,i) = linspace(P(2,i)+d,P(2,i+1),2);
       else
           Cpoint(2,i) = linspace(P(2,i)-d,P(2,i+1),2);
       end
   else if P(1,i) < P(1,i+1)
           Cpoint(2,i) = P(2,i)*ones(abs(P(1,i+1)-P(1,i))/d);
           Cpoint(1,i) = linspace(P(2,i)+d,P(2,i+1),2);
   else
          Cpoint(1,i) = linspace(P(2,i)-d,P(2,i+1),2);
       end
   end
end