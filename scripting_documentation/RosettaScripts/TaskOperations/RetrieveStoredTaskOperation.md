### RetrieveStoredTask

(This is a devel TaskOperation and not available in released versions.)

<!--- BEGIN_INTERNAL -->
Retrieves a stored packer task from the pose's cacheable data; must be used in conjunction with the StoreTask mover. Allows the caching and retrieval of tasks such that a packer task can be defined at an arbitrary point in a RosettaScripts protocol and used again later. This is useful when changes to the pose in the intervening time may result in a different packer task even though the same task operations are applied. Has the ancillary benefit of shortening the lists of task operations that frequently pepper RosettaScripts .xml files.

      <RetrieveStoredTask name=(&string) task_name=(&string) />

-   task\_name - The index where the stored task can be accessed in the pose's cacheable data. This must be identical to the task\_name used to store the task using the StoreTask mover.

<!--- END_INTERNAL --> 
