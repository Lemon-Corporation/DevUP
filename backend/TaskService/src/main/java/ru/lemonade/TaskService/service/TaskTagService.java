package ru.lemonade.TaskService.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.lemonade.TaskService.dto.tag.TaskTagDTO;
import ru.lemonade.TaskService.mapper.TaskTag.TaskTagMapper;
import ru.lemonade.TaskService.model.task.TaskTag;
import ru.lemonade.TaskService.repository.TaskTagRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Transactional
public class TaskTagService {
    private final TaskTagRepository taskTagRepository;
    private final TaskTagMapper taskTagMapper;

    @Transactional(readOnly = true)
    public List<TaskTagDTO> getAllTags() {
        return taskTagRepository.findAll().stream()
                .map(taskTagMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public TaskTagDTO getTaskTagById(Long id) {
        return taskTagRepository.findById(id)
                .map(taskTagMapper::toDTO)
                .orElseThrow(() -> new EntityNotFoundException("TaskTag not found with id: " + id));
    }

    @Transactional(readOnly = true)
    public List<TaskTagDTO> searchByTitle(String title) {
        return taskTagRepository.findByTitleContainingIgnoreCase(title).stream()
                .map(taskTagMapper::toDTO)
                .collect(Collectors.toList());
    }

    public TaskTagDTO addTaskTag(TaskTagDTO taskTagDTO) {
        TaskTag taskTag = taskTagMapper.toEntity(taskTagDTO);
        taskTag = taskTagRepository.save(taskTag);
        return taskTagMapper.toDTO(taskTag);
    }

    public TaskTagDTO updateTaskTag(Long id, TaskTagDTO taskTagDTO) {
        TaskTag existingTaskTag = taskTagRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("TaskTag not found with id: " + id));
        
        existingTaskTag.setTitle(taskTagDTO.getTitle());
        existingTaskTag = taskTagRepository.save(existingTaskTag);
        return taskTagMapper.toDTO(existingTaskTag);
    }

    public void deleteTaskTagById(Long id) {
        if (!taskTagRepository.existsById(id)) {
            throw new EntityNotFoundException("TaskTag not found with id: " + id);
        }
        taskTagRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public TaskTagDTO getTaskTagByTitle(String title) {
        return taskTagRepository.findByTitle(title)
                .map(taskTagMapper::toDTO)
                .orElseThrow(() -> new EntityNotFoundException("TaskTag not found with title: " + title));
    }
}
