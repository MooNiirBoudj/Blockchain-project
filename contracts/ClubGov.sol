// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ClubGov
 * @dev A simple DAO for a Scientific Club with treasury management and proposal voting
 */
contract ClubGov {
    // State variables
    address public owner;
    uint public memberCount;
    uint public proposalCount;
    
    // Mappings
    mapping(address => bool) public members;
    mapping(uint => Proposal) public proposals;
    
    // Structs
    struct Proposal {
        uint id;
        string description;
        uint amount;
        address payable recipient;
        uint yesVotes;
        uint noVotes;
        bool executed;
        bool active;
        mapping(address => bool) hasVoted;
    }
    
    // Events
    event MemberAdded(address indexed member);
    event MemberRemoved(address indexed member);
    event ProposalCreated(uint indexed proposalId, string description, uint amount, address recipient);
    event VoteCast(uint indexed proposalId, address indexed voter, bool support);
    event ProposalExecuted(uint indexed proposalId, address recipient, uint amount);
    event FundsReceived(address indexed sender, uint amount);
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    modifier onlyMember() {
        require(members[msg.sender], "Only members can perform this action");
        _;
    }
    
    modifier proposalExists(uint _proposalId) {
        require(_proposalId < proposalCount, "Proposal does not exist");
        _;
    }
    
    modifier proposalActive(uint _proposalId) {
        require(proposals[_proposalId].active, "Proposal is not active");
        _;
    }
    
    // Constructor
    constructor() {
        owner = msg.sender;
        members[msg.sender] = true;
        memberCount = 1;
    }
    
    // Receive function to accept ETH
    receive() external payable {
        emit FundsReceived(msg.sender, msg.value);
    }
    
    // Fallback function
    fallback() external payable {
        emit FundsReceived(msg.sender, msg.value);
    }
    
    /**
     * @dev Add a new member to the DAO
     * @param _member Address of the new member
     */
    function addMember(address _member) external onlyOwner {
        require(_member != address(0), "Invalid address");
        require(!members[_member], "Already a member");
        
        members[_member] = true;
        memberCount++;
        
        emit MemberAdded(_member);
    }
    
    /**
     * @dev Remove a member from the DAO
     * @param _member Address of the member to remove
     */
    function removeMember(address _member) external onlyOwner {
        require(members[_member], "Not a member");
        require(_member != owner, "Cannot remove owner");
        
        members[_member] = false;
        memberCount--;
        
        emit MemberRemoved(_member);
    }
    
    /**
     * @dev Create a new proposal
     * @param _description Description of the proposal
     * @param _amount Amount of ETH to transfer (in wei)
     * @param _recipient Address to receive the funds
     */
    function createProposal(
        string memory _description,
        uint _amount,
        address payable _recipient
    ) external onlyMember returns (uint) {
        require(_recipient != address(0), "Invalid recipient");
        require(_amount > 0, "Amount must be greater than 0");
        require(_amount <= address(this).balance, "Insufficient treasury balance");
        require(bytes(_description).length > 0, "Description cannot be empty");
        
        uint proposalId = proposalCount;
        Proposal storage newProposal = proposals[proposalId];
        
        newProposal.id = proposalId;
        newProposal.description = _description;
        newProposal.amount = _amount;
        newProposal.recipient = _recipient;
        newProposal.yesVotes = 0;
        newProposal.noVotes = 0;
        newProposal.executed = false;
        newProposal.active = true;
        
        proposalCount++;
        
        emit ProposalCreated(proposalId, _description, _amount, _recipient);
        
        return proposalId;
    }
    
    /**
     * @dev Vote on a proposal
     * @param _proposalId ID of the proposal
     * @param _support True for yes, false for no
     */
    function vote(uint _proposalId, bool _support) 
        external 
        onlyMember 
        proposalExists(_proposalId) 
        proposalActive(_proposalId) 
    {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.hasVoted[msg.sender], "Already voted on this proposal");
        
        proposal.hasVoted[msg.sender] = true;
        
        if (_support) {
            proposal.yesVotes++;
        } else {
            proposal.noVotes++;
        }
        
        emit VoteCast(_proposalId, msg.sender, _support);
    }
    
    /**
     * @dev Execute a proposal if it has reached the threshold
     * @param _proposalId ID of the proposal to execute
     */
    function executeProposal(uint _proposalId) 
        external 
        onlyMember 
        proposalExists(_proposalId) 
        proposalActive(_proposalId) 
    {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(address(this).balance >= proposal.amount, "Insufficient treasury balance");
        
        // Calculate required votes (51% of members)
        uint requiredVotes = (memberCount * 51) / 100;
        if (requiredVotes == 0) requiredVotes = 1; // At least 1 vote required
        
        require(proposal.yesVotes >= requiredVotes, "Proposal has not reached voting threshold");
        
        proposal.executed = true;
        proposal.active = false;
        
        // Transfer funds
        (bool success, ) = proposal.recipient.call{value: proposal.amount}("");
        require(success, "Transfer failed");
        
        emit ProposalExecuted(_proposalId, proposal.recipient, proposal.amount);
    }
    
    /**
     * @dev Cancel a proposal (only owner)
     * @param _proposalId ID of the proposal to cancel
     */
    function cancelProposal(uint _proposalId) 
        external 
        onlyOwner 
        proposalExists(_proposalId) 
        proposalActive(_proposalId) 
    {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Cannot cancel executed proposal");
        
        proposal.active = false;
    }
    
    /**
     * @dev Get proposal details
     * @param _proposalId ID of the proposal
     */
    function getProposal(uint _proposalId) 
        external 
        view 
        proposalExists(_proposalId) 
        returns (
            uint id,
            string memory description,
            uint amount,
            address recipient,
            uint yesVotes,
            uint noVotes,
            bool executed,
            bool active
        ) 
    {
        Proposal storage proposal = proposals[_proposalId];
        return (
            proposal.id,
            proposal.description,
            proposal.amount,
            proposal.recipient,
            proposal.yesVotes,
            proposal.noVotes,
            proposal.executed,
            proposal.active
        );
    }
    
    /**
     * @dev Check if an address has voted on a proposal
     * @param _proposalId ID of the proposal
     * @param _voter Address of the voter
     */
    function hasVoted(uint _proposalId, address _voter) 
        external 
        view 
        proposalExists(_proposalId) 
        returns (bool) 
    {
        return proposals[_proposalId].hasVoted[_voter];
    }
    
    /**
     * @dev Get the treasury balance
     */
    function getTreasuryBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    /**
     * @dev Check if an address is a member
     * @param _address Address to check
     */
    function isMember(address _address) external view returns (bool) {
        return members[_address];
    }
    
    /**
     * @dev Get the required votes for a proposal to pass
     */
    function getRequiredVotes() external view returns (uint) {
        uint requiredVotes = (memberCount * 51) / 100;
        return requiredVotes == 0 ? 1 : requiredVotes;
    }
}