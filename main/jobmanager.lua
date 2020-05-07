if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local OldFunc1 = JobManager._on_retry_job_stage
local OldFunc2 = JobManager.deactivate_current_job
local NewFunc = function()
	if SOHL and (SOHL.Enable or not SOHL.Checker) and not Network:is_client() then
		SOHL.Enable = nil
		SOHL.Checker = true
	end
end

function JobManager:_on_retry_job_stage()
	NewFunc()
	OldFunc1(self)
end

function JobManager:deactivate_current_job()
	NewFunc()
	OldFunc2(self)
end