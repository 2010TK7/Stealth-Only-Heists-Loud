if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local OldFunc1 = JobManager._on_retry_job_stage
local OldFunc2 = JobManager.deactivate_current_job
local NewFunc = function()
	if Network:is_client() then
		return
	end
	if SOHL then
		SOHL.Enable = nil
		SOHL.Checker = true
	end
end

function JobManager:_on_retry_job_stage()
	OldFunc1(self)
	NewFunc()
end

function JobManager:deactivate_current_job()
	OldFunc2(self)
	NewFunc()
end