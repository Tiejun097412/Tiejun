#利用拐点求其余控制顶点
import numpy as np

def Controlpoint(p_x,p_y,d):
    cp_x = [1]
    cp_y = [1]
    for i in range(0,len(p_x)-1,1):
        if p_x[i] == p_x[i+1]:
            cp_x.append(p_x[i]*np.ones(abs(p_y[i+1]-p_y[i])/d))
            if p_y[i] > p_y[i+1]:
                cp_y.append(np.linspace(p_y[i]+d,p_y[i+1],abs(p_y[i+1]-p_y[i])/d))
            else:
                cp_y.append(np.linspace(p_y[i]-d,p_y[i+1],abs(p_y[i+1]-p_y[i])/d))
        elif p_x[i] < p_x[i+1]:
            cp_y.append(p_y[i]*np.ones(abs(p_x[i+1]-p_x[i])/d))
            cp_x.append(np.linspace(p_y[i]+d,p_y[i+1],abs(p_y[i+1]-p_y[i])/d))
        else:
            cp_x.append(np.linspace(p_y[i]-d,p_y[i+1],abs(p_y[i+1]-p_y[i])/d))
    print(cp_x)
    print(cp_y)

if __name__ == '__main__':
  p_x = [1,1,2,2,3,3,1]
  p_y = [1,3,3,2,2,1,1]
  d = 0.1

