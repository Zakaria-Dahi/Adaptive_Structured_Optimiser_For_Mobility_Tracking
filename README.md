# Quick Description

**Programmer:shipit:**: Zakaria Abdelmoiz DAHI, University of Malaga, Spain. 

**About:** This repositiory implements the strcutred adaptive evolution algorithm devised and studied in [1] that solves the users' mobility tracking in cellular networks.

- [1] **Z.A. Dahi**, E. Alba, A. Draa, A stop-and-start adaptive cellular genetic algorithm for mobility management of GSM-LTE cellular network users, Expert Systems with Applications, Volume 106, 2018, Pages 290-304, ISSN 0957-4174, https://doi.org/10.1016/j.eswa.2018.02.041.

## **How :green_book:** 

- Depending on what you want to study or used, you can navigate to the folder `2SA-cGA` for running the devised algorithm or `SOTA` for running state-of-the-art algorithms.
- Tehn, you just need to run the Matlab script `main.m`.

## **Folders Hiearchy :open_file_folder:**
    
- `2SA-cGA`: contains the code of the devised approach.
  - `Firs_Set`: contains the code of our 2SA-cGA using the restart mechanism. It is performed for instances of size < 100 cells.
  - `Second_Set`: contains the code of our 2SA-cGA but without using the restart mechanism. It is performed for instances of size >= 100 cells.
- `SOTA`: contains the code of the state-of-the-art algorithms.
  - `DE`: implements the differential evolution algorithm.
  - `GPSO`: implements the the geometric particle swarm optimisation algorithm.
  - `OIGA`: implements the oscillatory increasing genetic algorithm.
- `Results`: Once executed the results are stored in excel files with name Network_a_bxc, where a represent the ID of networks of such shape, b and c represent the number of cells in the width and height of the network.
    
## **Demo :movie_camera:**
- Please refer to the original paper [HERE](https://link.springer.com/article/10.1007/s00500-019-04125-w) for more detailed results and discussions.
