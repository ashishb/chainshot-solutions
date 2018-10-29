// Solution to https://www.chainshot.com/challenges/5b74a4ebd9f9970a465ebd40/stage/5b74a620d9f9970a465ebd41

pragma solidity ^0.4.18;

contract Schedule {
    struct Meeting {
        uint date;
    }

    Meeting[] public meetings;

    /**
     * @notice Takes a list of uint timestamps and uses it to populate the meetings array 
     * @param dates An array of uint timestamps representing the meeting time
     */
    function Schedule(uint[] dates) public {
        for (uint i = 0; i < dates.length; i++) {
            meetings.push(Meeting(dates[i]));
        }
    }

    /**
     * @dev TODO: create this function findNextMeetingDate
     * @notice finds the next meeting and returns the unix timestamp
     * @return uint unix timestamp
     */
     function findNextMeetingDate() public returns (uint) {
         uint currentTime = now;
         uint nearestMeetingTime = 0;
         for (uint i = 0; i < meetings.length; i++) {
             if(meetings[i].date < currentTime) {
                 continue;
             }
             if(meetings[i].date < nearestMeetingTime || nearestMeetingTime == 0) {
                 nearestMeetingTime =  meetings[i].date;
             }
         }
         return nearestMeetingTime;
     }
}
