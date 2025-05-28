package ru.lemonade.TaskService.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.Transactional;
import ru.lemonade.TaskService.model.task.Task;
import ru.lemonade.TaskService.model.task.TaskComplexity;
import ru.lemonade.TaskService.model.task.TaskTag;
import ru.lemonade.TaskService.model.task.TaskType;
import ru.lemonade.TaskService.repository.TaskComplexityRepository;
import ru.lemonade.TaskService.repository.TaskRepository;
import ru.lemonade.TaskService.repository.TaskTagRepository;
import ru.lemonade.TaskService.repository.TaskTypeRepository;
import ru.lemonade.TaskService.settings.Constants;

import java.util.Arrays;
import java.util.HashSet;

@Configuration
public class InitConfig {
    @Bean
    @Transactional
    public CommandLineRunner initData(
            TaskTypeRepository taskTypeRepository,
            TaskTagRepository taskTagRepository,
            TaskComplexityRepository taskComplexityRepository,
            TaskRepository taskRepository) {
        return args -> {
            if (Constants.DEBUG) {
                // Initialize Task Types
                TaskType algorithmType = taskTypeRepository.findByTitle(Constants.ALGORITHM_TASK_TYPE)
                        .orElseGet(() -> {
                            TaskType type = new TaskType();
                            type.setTitle(Constants.ALGORITHM_TASK_TYPE);
                            return taskTypeRepository.save(type);
                        });

                TaskType optionType = taskTypeRepository.findByTitle(Constants.OPTION_TASK_TYPE)
                        .orElseGet(() -> {
                            TaskType type = new TaskType();
                            type.setTitle(Constants.OPTION_TASK_TYPE);
                            return taskTypeRepository.save(type);
                        });

                // Initialize Task Tags
                for (String tagTitle : Constants.TASK_TAGS) {
                    final String finalTagTitle = tagTitle;
                    taskTagRepository.findByTitle(finalTagTitle).orElseGet(() -> {
                        TaskTag tag = new TaskTag();
                        tag.setTitle(finalTagTitle);
                        return taskTagRepository.save(tag);
                    });
                }

                // Initialize Task Complexities
                for (int i = 0; i < Constants.TASK_COMPLEXITIES.length; i++) {
                    final String complexityTitle = Constants.TASK_COMPLEXITIES[i];
                    final int finalSortOrder = i;
                    taskComplexityRepository.findByTitle(complexityTitle).orElseGet(() -> {
                        TaskComplexity complexity = new TaskComplexity();
                        complexity.setTitle(complexityTitle);
                        complexity.setSortOrder(finalSortOrder);
                        return taskComplexityRepository.save(complexity);
                    });
                }

                // Initialize Test Tasks
                TaskComplexity easyComplexity = taskComplexityRepository.findByTitle(Constants.TASK_COMPLEXITIES[0])
                        .orElseThrow(() -> new RuntimeException("Easy complexity not found"));
                TaskComplexity mediumComplexity = taskComplexityRepository.findByTitle(Constants.TASK_COMPLEXITIES[1])
                        .orElseThrow(() -> new RuntimeException("Medium complexity not found"));

                TaskTag mathTag = taskTagRepository.findByTitle(Constants.TASK_TAGS[0])
                        .orElseThrow(() -> new RuntimeException("Math tag not found"));
                TaskTag programmingTag = taskTagRepository.findByTitle(Constants.TASK_TAGS[1])
                        .orElseThrow(() -> new RuntimeException("Programming tag not found"));

                // Create Algorithm Task
                Task algorithmTask = new Task();
                algorithmTask.setTitle("Найти сумму чисел");
                algorithmTask.setDescription("Напишите функцию, которая принимает массив чисел и возвращает их сумму");

                algorithmTask.setType(algorithmType);
                algorithmTask.setComplexity(easyComplexity);
                algorithmTask.setTags(new HashSet<>(Arrays.asList(mathTag, programmingTag)));
                taskRepository.save(algorithmTask);

                // Create Option Task
                Task optionTask = new Task();
                optionTask.setTitle("Выберите правильный ответ");
                optionTask.setDescription("Какое из следующих утверждений о Java верно?");

                optionTask.setType(optionType);
                optionTask.setComplexity(mediumComplexity);
                optionTask.setTags(new HashSet<>(Arrays.asList(programmingTag)));
                taskRepository.save(optionTask);
            }
        };
    }
} 