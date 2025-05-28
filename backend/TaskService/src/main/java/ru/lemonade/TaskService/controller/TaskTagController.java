package ru.lemonade.TaskService.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.TaskService.dto.tag.TaskTagDTO;
import ru.lemonade.TaskService.service.TaskTagService;
import ru.lemonade.TaskService.settings.ApiPaths;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping(ApiPaths.TASK_TAGS_URL)
public class TaskTagController {
    private final TaskTagService taskTagService;

    @GetMapping
    public List<TaskTagDTO> getAllTaskTags() {
        return taskTagService.getAllTags();
    }

    @GetMapping("/{id}")
    public TaskTagDTO getTaskTagById(@PathVariable Long id) {
        return taskTagService.getTaskTagById(id);
    }

    @GetMapping("/search")
    public List<TaskTagDTO> searchTaskTags(@RequestParam String title) {
        return taskTagService.searchByTitle(title);
    }

    @PostMapping
    public TaskTagDTO addTaskTag(@Valid @RequestBody TaskTagDTO taskTagDTO) {
        return taskTagService.addTaskTag(taskTagDTO);
    }

    @PutMapping("/{id}")
    public TaskTagDTO updateTaskTag(
            @PathVariable Long id,
            @Valid @RequestBody TaskTagDTO taskTagDTO) {
        return taskTagService.updateTaskTag(id, taskTagDTO);
    }

    @DeleteMapping("/{id}")
    public void deleteTaskTag(@PathVariable Long id) {
        taskTagService.deleteTaskTagById(id);
    }
} 