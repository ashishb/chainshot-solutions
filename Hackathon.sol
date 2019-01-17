// Solution to https://www.chainshot.com/challenges/5bb406cad9f997a89a01f6eb/stage/5bb4072bd9f997a89a01f6ec
pragma solidity ^0.4.18;

contract Hackathon {
  struct Project {
    string title;
    uint[] ratings;
  }
  Project[] projects;
  
  // TODO: add the findWinner function

  function findWinner() returns (string _winnerTitle) {
    uint maxTotalRating = 0;
    uint maxtTotalRaters = 0;
    uint winnerId = 0;

    for (uint i = 0; i < projects.length; i++) {
      uint tmpTotalRating = addAll(projects[i].ratings);
      uint tmpTotalRaters = projects[i].ratings.length;
      if (maxTotalRating == 0 || (maxTotalRating * tmpTotalRaters < tmpTotalRating * maxtTotalRaters)) {
        maxTotalRating = tmpTotalRating;
        maxtTotalRaters = tmpTotalRaters;
        winnerId = i;
      }
    }
    _winnerTitle = projects[winnerId].title;
  }

  function addAll(uint[] _numbers) returns (uint _sum) {
    for(uint i = 0; i < _numbers.length; i++) {
      _sum += _numbers[i];
    }
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
