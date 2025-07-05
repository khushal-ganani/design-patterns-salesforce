public class CaseOwnerAssigner {
    public void assignQueue(List<Case> newCases) {
        Group queue = [SELECT Id FROM Group WHERE Name = 'Support Queue' LIMIT 1];
        for (Case c : newCases) {
            c.OwnerId = queue.Id;
        }
    }
}
