pragma solidity ^0.4.18;

contract Hackathon {
  struct Project {
    string title;
    uint[] ratings;
  }
  Project[] projects;
  
  // findWinner function
  function findWinner() public view returns (string){

    if(projects.length == 1){
      return projects[0].title;
    }

    uint top_curr_avg = 0;
    uint curr_top_proj_inx = 0;

    for(uint i; i < projects.length; i++){
      Project storage instance = projects[i];

      //get average of instance project
      uint total_rate = 0;
      for(uint j; j < instance.ratings.length; j++){
        total_rate = total_rate + instance.ratings[j];
      }

      uint256 instance_avg = total_rate / instance.ratings.length; //total rating / number of ratings = average

      //compare to 
      if(instance_avg < top_curr_avg){
        //new highest
        top_curr_avg = instance_avg;
        curr_top_proj_inx = i;
      }
      //check next
    }

    //grab best project
    //return its name
    return projects[curr_top_proj_inx].title;
    //return "Winning";
  }
  
  function newProject(string _title) public {
    // creates a new project with a title and an empty ratings array
    projects.push(Project(_title, new uint[](0)));
  }

  function rate(uint _idx, uint _rating) public {
    // rates a project by its index
    projects[_idx].ratings.push(_rating);
  }
}
